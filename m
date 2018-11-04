Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7F7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7862C2082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PMZutOfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7862C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeKEHWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:22:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeKEHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y6w4G/tnTF20WdNp6H4+sCM3ntZCnz1IQthYWAUVuq4=; b=PMZutOfo1HcbBhVC4FpI9evPIp
        hnau2Scy7buric7Gg4VLptaKlZHfSELUg83jUYycrYLT66SAYvVYH32mT6YdIW+86AMm4rqdtMTP2
        Yz2fwrknpN45LtykshJ3mxyC3XFx9es86uOlv4afdEfmdNgbaH2eq8LXs0gohhsJkSZsLOV/zSClY
        PH5+nYIbAPciyOCWvKmffhqIF+XmHmhuGZinS3dmFFpmGmob01cra0al5r4nWzXbf8bUWqE8hIdsc
        nOIyCdE/SuWKAMZA13TJiN57J2x/2VJuWoG4WHajgxIwaDG1kFjnttk3YcqEbXQ9q6sHrBydoOroO
        KJoguJ8A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJQXI-0007jh-7T; Sun, 04 Nov 2018 22:06:24 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend] Documentation/dev-tools: clean up kselftest.rst
Message-ID: <67201746-13c6-2b05-7f3d-2b200e4d9af0@infradead.org>
Date:   Sun, 4 Nov 2018 14:06:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

This is a small cleanup to kselftest.rst:

- Fix some language typos in the usage instructions.
- Change one non-ASCII space to an ASCII space.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/dev-tools/kselftest.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20181101.orig/Documentation/dev-tools/kselftest.rst
+++ linux-next-20181101/Documentation/dev-tools/kselftest.rst
@@ -9,7 +9,7 @@ and booting a kernel.
 
 On some systems, hot-plug tests could hang forever waiting for cpu and
 memory to be ready to be offlined. A special hot-plug target is created
-to run full range of hot-plug tests. In default mode, hot-plug tests run
+to run the full range of hot-plug tests. In default mode, hot-plug tests run
 in safe mode with a limited scope. In limited mode, cpu-hotplug test is
 run on a single cpu as opposed to all hotplug capable cpus, and memory
 hotplug test is run on 2% of hotplug capable memory instead of 10%.
@@ -89,9 +89,9 @@ Note that some tests will require root p
 Install selftests
 =================
 
-You can use kselftest_install.sh tool installs selftests in default
-location which is tools/testing/selftests/kselftest or a user specified
-location.
+You can use the kselftest_install.sh tool to install selftests in the
+default location, which is tools/testing/selftests/kselftest, or in a
+user specified location.
 
 To install selftests in default location::
 
@@ -109,7 +109,7 @@ Running installed selftests
 Kselftest install as well as the Kselftest tarball provide a script
 named "run_kselftest.sh" to run the tests.
 
-You can simply do the following to run the installed Kselftests. Please
+You can simply do the following to run the installed Kselftests. Please
 note some tests will require root privileges::
 
    $ cd kselftest
@@ -139,7 +139,7 @@ Contributing new tests (details)
    default.
 
    TEST_CUSTOM_PROGS should be used by tests that require custom build
-   rule and prevent common build rule use.
+   rules and prevent common build rule use.
 
    TEST_PROGS are for test shell scripts. Please ensure shell script has
    its exec bit set. Otherwise, lib.mk run_tests will generate a warning.


