Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA8D20684
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA8D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeIQJHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:07:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44409 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeIQJHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:07:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so6735628plb.11;
        Sun, 16 Sep 2018 20:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rML5Wltx1r2sF8iF34Q7S9vp+4dA4MBU7NHbYjw9mV8=;
        b=iw+HGcUDacv0Q8oJDM0GIx4eRwHBAnCO0FLj3kO/mDR6VZNkgoKJ9NokKrBMOPrF3o
         BtjAcgi7n3T/jbdx/thpNrRZlxlSSyntIcfytrkcyrwksH7QgeTigGx5xTYgbyPH3n0q
         Jaz79DVrGeKvqhjGI4UaJp7nawxzzk2/DMgsa/hXkm9BO0EFuRG8oObG0qeq7Q8b0cGR
         v0wqlWyO4tYW9b6G+rz2rm2GDVHp39p5S28o2XGlcfEVFHJpKtuE0mRENJ3TVAnlVDmK
         S/X/r1nL7BHniw+1qn102CGD2vt7FMex63gCxtnFQHq9OgTmh3dpP5n8NJS/eHUGv/5B
         Sy0Q==
X-Gm-Message-State: APzg51C1E5biFUIXkN2xpeqPI5NtHRA6ZW1xKxy7W5ltYnClC+77azC9
        3ivL96lwSQsz+eqy9F6gigU0IB6z
X-Google-Smtp-Source: ANB0VdYD8PkLF6fldd5sWcJ7pMD/uK+p/+oXOBMSjQqjc0/M8RCttIbmQgcQpNPgVuHgXvOOR8Y2JA==
X-Received: by 2002:a17:902:d703:: with SMTP id w3-v6mr6989332ply.132.1537155705642;
        Sun, 16 Sep 2018 20:41:45 -0700 (PDT)
Received: from ?IPv6:2405:6580:9660:3200:60c7:933c:fe9f:29ca? ([2405:6580:9660:3200:60c7:933c:fe9f:29ca])
        by smtp.gmail.com with ESMTPSA id s16-v6sm16559845pfm.114.2018.09.16.20.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 20:41:44 -0700 (PDT)
Subject: Re: [PATCH] Documentation: soundwire: fix stream.rst markup warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <8e1ec734-06b8-ba8a-fdca-3221ac134ea0@infradead.org>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <b14e406b-0988-22d3-4d1f-6809c4d77610@sakamocchi.jp>
Date:   Mon, 17 Sep 2018 12:41:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8e1ec734-06b8-ba8a-fdca-3221ac134ea0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sep 17 2018 09:34, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc markup warnings in soundwire/stream.rst:
> 
> rc4/Documentation/driver-api/soundwire/stream.rst:177: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:203: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:248: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:277: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:304: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:328: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:352: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:364: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> 
> Fixes: 89634f99a83e ("Documentation: soundwire: Add more documentation")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> Cc: Shreyas NC <shreyas.nc@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/driver-api/soundwire/stream.rst |    8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
