Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B806C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F7420BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F7420BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeGLMY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:24:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39014 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeGLMY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:24:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so21721137eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3sT/FsQFvTDAja/VBztiba0P766hrNTQ9FErUKpvl4E=;
        b=dyQXKaK5gCyQfOcPkl5hsdw5y7144amK1gD/EzkZJ4mBdZ8FevDc+gZ17YrXpl8aRj
         Vz0kT6T9ZBFbV30RLNSXcpukbgW+K1HG+SkwdAR1JtERAeEn3HK1a+jq2/dVzyK5xoj3
         ofekPK5KMog7D2/u25D7qEmMAhnYsmEFaumxqMRstVl+5u5BNyeZSkJmmfREISzSs0vR
         sWAYRqW86GfQQziANn3Ifl7Yk4Xh4HSzyunUOTSDWapldwZUNcFBF21UUm076TQf2dYJ
         THvQLU4xeSpQRi3QOjyYZ/zKqHVrGsLpi/rhoiMjnbyPLAPCfzPty6aFIH/eLc28Hqqm
         PFKA==
X-Gm-Message-State: AOUpUlEHGe+YoV92W+T1Dj1RUnbZPLgeo/mo5MS4w41kQUntyqHpizg5
        gZ91Bn2zsV+ARJI8HewrNhwKP++wht0=
X-Google-Smtp-Source: AAOMgpeBAb8LGzDNkVUYYx2A7GGknJBPWd794s6EqXwTrV1eJjaUzpE6aiFNJLqpco3TdTbMx6IFJQ==
X-Received: by 2002:a50:b1f3:: with SMTP id n48-v6mr2284743edd.197.1531397737698;
        Thu, 12 Jul 2018 05:15:37 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r5-v6sm10109206edp.60.2018.07.12.05.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 05:15:37 -0700 (PDT)
Subject: Re: [PATCH 0/3] ata: ahci_platform: minor fixes
To:     Corentin Labbe <clabbe@baylibre.com>, tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c02497e3-f4a7-a4fa-8dfa-f3d3de299e38@redhat.com>
Date:   Thu, 12 Jul 2018 14:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-07-18 13:41, Corentin Labbe wrote:
> Hello
> 
> This patchset fixes some minor problem found when working on supporting
> allwinner R40 AHCI.
> 
> Regards

Thanks.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

