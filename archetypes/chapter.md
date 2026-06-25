+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
weight = 10
chapter_key = '{{ .File.ContentBaseName }}'
description = 'Short one-line description for cards/sidebar.'
icon = 'tree'
+++

Optional introductory markdown for the chapter. The algorithm table below is
rendered from `data/algorithms/<chapter_key>.yaml`.
