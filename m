Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeFEWt7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:49:59 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:60834 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbeFEWt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:49:57 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 2/6] doc:sphinx: fix parse-header description
Date: Wed,  6 Jun 2018 00:48:59 +0200
Message-Id: <20180605224903.9483-3-federico.vaga@vaga.pv.it>
In-Reply-To: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
References: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description speaks about the option ``--man`` but it
does not exist. Instead, there is the option ``--usage``

    $ ./Documentation/sphinx/parse-headers.pl --man
    Unknown option: man
    Usage:
        parse_headers.pl [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]

        Where <options> can be: --debug, --help or --man.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/doc-guide/parse-headers.rst | 2 +-
 Documentation/sphinx/parse-headers.pl     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
index 684490c68acb..24cfaa15dd81 100644
--- a/Documentation/doc-guide/parse-headers.rst
+++ b/Documentation/doc-guide/parse-headers.rst
@@ -32,7 +32,7 @@ SYNOPSIS
 
 \ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
 
-Where <options> can be: --debug, --help or --man.
+Where <options> can be: --debug, --help or --usage.
 
 
 OPTIONS
diff --git a/Documentation/sphinx/parse-headers.pl b/Documentation/sphinx/parse-headers.pl
index d410f47567e9..c518050ffc3f 100755
--- a/Documentation/sphinx/parse-headers.pl
+++ b/Documentation/sphinx/parse-headers.pl
@@ -344,7 +344,7 @@ enums and defines and create cross-references to a Sphinx book.
 
 B<parse_headers.pl> [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
 
-Where <options> can be: --debug, --help or --man.
+Where <options> can be: --debug, --help or --usage.
 
 =head1 OPTIONS
 
-- 
2.14.4
