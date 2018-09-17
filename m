Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16166ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CB0214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kaP12ArP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CB0214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeIQF7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:59:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeIQF7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KnE3gJDkLmhOgG+K0GQ+XXCqeFaR4hiNuouJt+m5QRA=; b=kaP12ArP69gLSAeWip+9NrsEh
        0mhiYl/6fG5taiuJ1GLF2juMll8y9Pjo2bqZRBHKfKz+SFmDxYOy3/Z33QRDEG6iWrBQmteVuO/XH
        vPgokLZNPj/Bi2jP8p5WkhH+AeRAIUI3319QiiHlqTsLPfYwkCsUT35joMroJe5ScslviDtfwQnE5
        xRf2w/ltO56QPzw8pj6ndHH5kHfX9BjSL7LhK/+/PdC+tUxMR/8GxDb3weInEmB945M2l3trQitS8
        Vt3IQEGlgLY7oLPeKPj8fxG8ddT8UcO2nWnH2G33MNnSIbuUcw/gYrW4EZqI2TdzlOrts2TLaBftf
        DiPBsb3JA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1hV4-0000Hb-Hi; Mon, 17 Sep 2018 00:34:50 +0000
To:     moderated for non-subscribers <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: soundwire: fix stream.rst markup warnings
Message-ID: <8e1ec734-06b8-ba8a-fdca-3221ac134ea0@infradead.org>
Date:   Sun, 16 Sep 2018 17:34:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc markup warnings in soundwire/stream.rst:

rc4/Documentation/driver-api/soundwire/stream.rst:177: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:203: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:248: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:277: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:304: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:328: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:352: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:364: WARNING: Explicit markup ends without a blank line; unexpected unindent.

Fixes: 89634f99a83e ("Documentation: soundwire: Add more documentation")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Shreyas NC <shreyas.nc@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/driver-api/soundwire/stream.rst |    8 ++++++++
 1 file changed, 8 insertions(+)

--- lnx-419-rc4.orig/Documentation/driver-api/soundwire/stream.rst
+++ lnx-419-rc4/Documentation/driver-api/soundwire/stream.rst
@@ -174,6 +174,7 @@ per stream. From ASoC DPCM framework, th
 .startup() operation.
 
   .. code-block:: c
+
   int sdw_alloc_stream(char * stream_name);
 
 
@@ -200,6 +201,7 @@ only be invoked once by respective Maste
 framework, this stream state is linked to .hw_params() operation.
 
   .. code-block:: c
+
   int sdw_stream_add_master(struct sdw_bus * bus,
 		struct sdw_stream_config * stream_config,
 		struct sdw_ports_config * ports_config,
@@ -245,6 +247,7 @@ stream. From ASoC DPCM framework, this s
 .prepare() operation.
 
   .. code-block:: c
+
   int sdw_prepare_stream(struct sdw_stream_runtime * stream);
 
 
@@ -274,6 +277,7 @@ stream. From ASoC DPCM framework, this s
 .trigger() start operation.
 
   .. code-block:: c
+
   int sdw_enable_stream(struct sdw_stream_runtime * stream);
 
 SDW_STREAM_DISABLED
@@ -301,6 +305,7 @@ per stream. From ASoC DPCM framework, th
 .trigger() stop operation.
 
   .. code-block:: c
+
   int sdw_disable_stream(struct sdw_stream_runtime * stream);
 
 
@@ -325,6 +330,7 @@ per stream. From ASoC DPCM framework, th
 .trigger() stop operation.
 
   .. code-block:: c
+
   int sdw_deprepare_stream(struct sdw_stream_runtime * stream);
 
 
@@ -349,6 +355,7 @@ all the Master(s) and Slave(s) associate
 framework, this stream state is linked to .hw_free() operation.
 
   .. code-block:: c
+
   int sdw_stream_remove_master(struct sdw_bus * bus,
 		struct sdw_stream_runtime * stream);
   int sdw_stream_remove_slave(struct sdw_slave * slave,
@@ -361,6 +368,7 @@ stream assigned as part of ALLOCATED sta
 In .shutdown() the data structure maintaining stream state are freed up.
 
   .. code-block:: c
+
   void sdw_release_stream(struct sdw_stream_runtime * stream);
 
 Not Supported

