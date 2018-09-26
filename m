Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB67C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D762920842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="o/u8/UPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D762920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeIZU3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:29:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51766 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIZU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:34 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E48695C0452;
        Wed, 26 Sep 2018 16:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537971382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hj8Ul7f6rJMcT4zxhmUo0TqjWwKvRa9H2WlFNCyjKOM=;
        b=o/u8/UPqD+nKDpMMEC7Y+QmAJxarucloWvIyUL4b1cI4bCVoV++UQNOWV8/0aBIMdwyeh4
        vygh9oTtt+MiSQXf7hMygZATZUeaIIYiqVDT6jn50nOvzSW+IUhyWRDAn0BfZKtQbSQF37
        C2+++Q5+RNk3dDBEULEM30aTsnViMsE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Sep 2018 16:16:22 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     alison.wang@nxp.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Move fsl-dcu driver to drm-misc tree
In-Reply-To: <20180926133945.GR72545@art_vandelay>
References: <20180926125034.4095-1-stefan@agner.ch>
 <20180926133945.GR72545@art_vandelay>
Message-ID: <76874612e9f8613c16962c82e900a812@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2018 15:39, Sean Paul wrote:
> On Wed, Sep 26, 2018 at 02:50:34PM +0200, Stefan Agner wrote:
>> The driver is mostly in maintenance mode.
> 
> Is the status still Supported, then?
> 

Yeah Supported as defined in MAINTAINERS is still accurate. Its just
that we do not add features at that point.

>> Using drm-misc is a
>> good fit and should make maintenance a bit easier.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Acked-by: Sean Paul <sean@poorly.run>
> 

Thanks.

--
Stefan

>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 02a39617ec82..6646a3d098a1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4822,6 +4822,7 @@ F:	drivers/gpu/drm/fsl-dcu/
>>  F:	Documentation/devicetree/bindings/display/fsl,dcu.txt
>>  F:	Documentation/devicetree/bindings/display/fsl,tcon.txt
>>  F:	Documentation/devicetree/bindings/display/panel/nec,nl4827hc19-05b.txt
>> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>>
>>  DRM DRIVERS FOR FREESCALE IMX
>>  M:	Philipp Zabel <p.zabel@pengutronix.de>
>> --
>> 2.19.0
>>
