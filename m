Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D64C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BCB21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BCB21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitmer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeKLC6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:58:10 -0500
Received: from 50-87-157-213.static.tentacle.fi ([213.157.87.50]:40856 "EHLO
        bitmer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbeKLC6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:58:09 -0500
X-Greylist: delayed 1880 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2018 21:58:09 EST
Received: from dsl-hkibng31-54fae8-145.dhcp.inet.fi ([84.250.232.145] helo=[192.168.1.42])
        by bitmer.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <jarkko.nikula@bitmer.com>)
        id 1gLsk4-0008Gk-77; Sun, 11 Nov 2018 18:37:44 +0200
Subject: Re: [RFC 0/9] ASoC/ARM: Merge the davinci and omap audio directories
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, tony@atomide.com,
        nsekhar@ti.com
Cc:     alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jsarha@ti.com
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
From:   Jarkko Nikula <jarkko.nikula@bitmer.com>
Message-ID: <1065fb8a-a8ec-fbe3-83eb-a308072ef6d6@bitmer.com>
Date:   Sun, 11 Nov 2018 18:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 10:37 AM, Peter Ujfalusi wrote:
> The series also includes patches to updated the arch/arm/ files (defconfigs,
> source files using audio Kconfig symbols).
> 
> I believe with v1 all of this can be merged via ASoC tree as the chances of
> conflicts are low for the touched arch/arm files. But Sekhar and Tony can
> correct me if I'm wrong.
> 
> I think I have catched all (I hope) issues regarding to Kconfig thanks to the
> various autobuild machines out there kindly testing my linux-next-wip branch.
> 
> I would appreciate any testing comments before I send the v1!
> 
I applied on top of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git commit
abd97b7c53ac ("Merge branch 'asoc-4.21' into asoc-next").

Patches 2 and 6 didn't apply and 7-8 I skipped. For my functional
testing none of those were required.

For the sound/soc/{omap => ti} conversion you may add:

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
