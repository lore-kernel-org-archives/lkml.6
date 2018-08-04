Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D024DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C2921829
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C2921829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeHDXuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:50:20 -0400
Received: from gateway36.websitewelcome.com ([192.185.179.26]:43361 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728883AbeHDXuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:50:20 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id D17CD400CB8BF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 15:50:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m4PHfc9hqkBj6m4PHfucoH; Sat, 04 Aug 2018 16:48:15 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=33764 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fm4PG-002kHn-BL; Sat, 04 Aug 2018 16:48:14 -0500
Date:   Sat, 4 Aug 2018 16:48:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     patches@opensource.cirrus.com, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 00/12] ASoC: codecs: use true and false for boolean values
Message-ID: <cover.1533418275.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1fm4PG-002kHn-BL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:33764
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset aims to replace the use of integer values with a
proper true or false in return statements for functions returning
bool.

Thanks

Gustavo A. R. Silva (12):
  ASoC: max9850: use true and false for boolean values
  ASoC: rt5631: use true and false for boolean values
  ASoC: tda7419: use true and false for boolean values
  ASoC: wm8990: use true and false for boolean values
  ASoC: cs4270: use true and false for boolean values
  ASoC: wm8996: use true and false for boolean values
  ASoC: da7219: use true and false for boolean values
  ASoC: twl6040: use true and false for boolean values
  ASoC: da7213: use true and false for boolean values
  ASoC: wm5100-tables: use true and false for boolean values
  ASoC: da9055: use true and false for boolean values
  ASoC: wm8903: use true and false for boolean values

 sound/soc/codecs/cs4270.c        |  2 +-
 sound/soc/codecs/da7213.c        |  4 ++--
 sound/soc/codecs/da7219.c        |  4 ++--
 sound/soc/codecs/da9055.c        |  4 ++--
 sound/soc/codecs/max9850.c       |  4 ++--
 sound/soc/codecs/rt5631.c        |  8 ++++----
 sound/soc/codecs/tda7419.c       |  4 ++--
 sound/soc/codecs/twl6040.c       |  2 +-
 sound/soc/codecs/wm5100-tables.c | 12 ++++++------
 sound/soc/codecs/wm8903.c        |  4 ++--
 sound/soc/codecs/wm8990.c        |  4 ++--
 sound/soc/codecs/wm8996.c        |  8 ++++----
 12 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.7.4

