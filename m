Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35486C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D591C2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D591C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeHaNBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:01:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:44786 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeHaNBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:01:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 01:55:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="87859916"
Received: from ssirohi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.112])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2018 01:55:05 -0700
Date:   Fri, 31 Aug 2018 11:55:04 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: Add me as a keys/trusted maintainer
Message-ID: <20180831085504.GB12908@linux.intel.com>
References: <20180814145759.11581-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814145759.11581-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David, what do you think?

/Jarkko

On Tue, Aug 14, 2018 at 05:57:48PM +0300, Jarkko Sakkinen wrote:
> As a TPM maintainer I have to review all these commits. This commit is
> just to make that documented.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3119bba7971c..4b51c13ae2d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7928,6 +7928,7 @@ F:	security/keys/encrypted-keys/
>  KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.vnet.ibm.com>
>  M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
> +M:	Jarkko Sakkkinen <jarkko.sakkinen@linux.intel.com>
>  L:	linux-integrity@vger.kernel.org
>  L:	keyrings@vger.kernel.org
>  S:	Supported
> -- 
> 2.17.1
> 
