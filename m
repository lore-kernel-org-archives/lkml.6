Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB3EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03082084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Lw/WG3ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03082084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeJAPF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:05:59 -0400
Received: from aer-iport-4.cisco.com ([173.38.203.54]:6225 "EHLO
        aer-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbeJAPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:05:59 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 11:05:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=790; q=dns/txt; s=iport;
  t=1538382565; x=1539592165;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zF1BR4V04Fqbj9GPmSV+qGIwL8I/B/Qq+JXUdZhfA6M=;
  b=Lw/WG3eyddfRKg3GDT/gRkX5WB5WNGpaGvx/DPhO0qlAGwY3whPuw/pQ
   COetufKS9tNEsQg9ZuIBvrS6Y+8pdJE+wGXhKdXV37gVfMHcbEjETDBok
   zOLVKkhpzb6zEx8PQ6FGo97VWqf4MeNKhstdN+E40DQlYy0df7bPOnEIn
   E=;
X-IronPort-AV: E=Sophos;i="5.54,327,1534809600"; 
   d="scan'208";a="6856760"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 08:19:41 +0000
Received: from [10.61.162.38] ([10.61.162.38])
        (authenticated bits=0)
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id w918JehF018920
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 1 Oct 2018 08:19:40 GMT
Subject: Re: [PATCH] MAINTAINERS: fix reference to STI CEC driver
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, hans.verkuil@cisco.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20181001074640.16342-1-benjamin.gaignard@st.com>
From:   Hans Verkuil <hansverk@cisco.com>
Message-ID: <0980c4e8-f2f6-c480-66f0-9638b624b0b0@cisco.com>
Date:   Mon, 1 Oct 2018 10:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181001074640.16342-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-User: hansverk
X-Outbound-SMTP-Client: 10.61.162.38, [10.61.162.38]
X-Outbound-Node: aer-core-1.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/18 09:46, Benjamin Gaignard wrote:
> STI CEC driver has move from staging directory to media/platform/sti/cec/
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Added CC to linux-media so it's picked up by patchwork.

	Hans

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b22e7fdfd2ea..8aa973410e2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13870,7 +13870,7 @@ F:	sound/soc/sti/
>  STI CEC DRIVER
>  M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
>  S:	Maintained
> -F:	drivers/staging/media/st-cec/
> +F:	drivers/media/platform/sti/cec/
>  F:	Documentation/devicetree/bindings/media/stih-cec.txt
>  
>  STK1160 USB VIDEO CAPTURE DRIVER
> 

