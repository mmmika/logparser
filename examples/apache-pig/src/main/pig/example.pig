-- -------------------------------------------------------------
-- Apache HTTPD & NGINX Access log parsing made easy
-- Copyright (C) 2011-2018 Niels Basjes
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- -------------------------------------------------------------

REGISTER lib/*.jar;

%declare LOGFILE   '${ACCESS_LOGPATH}/access*.gz'
%declare LOGFORMAT '${ACCESS_LOGFORMAT}'

Fields =
  LOAD 'fields.sh'
  USING nl.basjes.pig.input.apachehttpdlog.Loader( '$LOGFORMAT',
            'example',
            '-map:request.firstline.uri.query.g:HTTP.URI',
            '-map:request.firstline.uri.query.r:HTTP.URI',
            '-load:nl.basjes.parse.UrlClassDissector:'
        ) AS (
            fields:chararray
        );

DUMP Fields;
