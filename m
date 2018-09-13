Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F9C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CDF20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CDF20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIMK65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:58:57 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeIMK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:58:56 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MiJdI-1fOEHo3aCs-00fPlD; Thu, 13 Sep 2018 07:50:38 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/3] bcm2835-defconfig-next-2018-09-09
Date:   Thu, 13 Sep 2018 07:50:33 +0200
Message-Id: <1536817833-3900-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
References: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:2wzN74Yr7yfS7MgI9b+Ro5zWeNaep5QncSeF8/UNlKldokgFY8Y
 ddwWwzzYiyWKNDyaiGH3QDJsi2G90P2ajmIsN5jwVAK53epgRA3iMx88geZAbdX34u99UnH
 rksVSua5gKU7iLanaFF5yyiyuJBze23l6XFR2nogU39gTje1ZkEUZ4e6KgGgTjcPQqNgHTb
 WcrXM4cTXPo0eq7RXYkWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vp6YBokcGEM=:DRRNz2Nqju1mzoPPZubo80
 ils66QqB5yd/oZ53OOEkfPp2xUBPeD3852J5eGBu5AhFxBE6v+CCyoJIqMMj5W6UrGyu7yi7B
 878HgvTGeHEw43WIq3QEhPsHhUMYHc32iY/CK/fwQeVMALjM6YIauifQoCBRtsepVbFgBLVN6
 KPrsVIPyJC/aTqSZBTQdkWPIbwacKjd3IrYRkoIdwXZke4AtOXOtUUD34baNyOHX/d0DNwlTv
 OQZgVg7nHZ/uFU6X9FyQuhZxuuMMwbs2gMvCNbfGnDOIl698wJSE2mkJphC1pYADxxyjTt/TK
 kMUTIqZa6F4eHLvL7TlIohd2BlFNpj3N2iqSbLbbAke8YeMio1KF6UD13jLkSgRBLdfGcdGUv
 SrueGoIgV4OfRXZtNgdzA8Ws/hKYVoZhzBbTD7CH3oAotNNE9uao2PYy44cJojVseJOJE9Cey
 D+hZkRy3Xst79LsF58Gelv63aM9nXzWGpxljoUQwKSAeeylKdeBpDgqLwQREb70YaRnwlzAOc
 LBVl/+32QkZbenvtgR22e09Hu2C8TN9VkPr4pZyDTWuSN4JaQgUK0exn3e4H6UlHY180ByVyI
 E8HkDxEYYCctQ0yzhUmxtKGQevIJFA8+sgerbjmytrpvX8PeVeGFIFJhM+tngd6FAsojx1YJ3
 0dCN8ZnDnPJVl4UleIclWjuN5mRKPXsNiYOA1BZf34QVtuVsVEd2VQIPl8ZJsBFc5hzM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-09-09

for you to fetch changes up to 99fa3b0c6082bff346f7d09f29e5edcc93d40bd3:

  ARM: bcm2835_defconfig: Enable bcm2835-audio (2018-09-02 18:49:33 +0200)

----------------------------------------------------------------
This pull request brings enables the RPi audio driver in the
bcm2835_defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable bcm2835-audio

 arch/arm/configs/bcm2835_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
