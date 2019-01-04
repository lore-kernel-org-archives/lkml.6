Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA62C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645942070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546612815;
	bh=Zl3/URiqzpvTB3vS6mRLLA7ulMgDYB+jSLkrr1Xe/4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eCa9RqSeit4mB6HCEwTwVLpHp6vHSVCqOQ4F5/ct1cDB58T3dYyQgcsqvOn9DFAj9
	 XoUa02XDdPT+6AdpzbrKcwo27FzwaNOzdfNW21spwYVNv3sN0EEU+iugnNH4qeJMbn
	 v8rip9Vtglci+Mtj6Z3ayd9BsSirp06fQSXrm+kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfADOkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfADOkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:40:14 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAF12070C;
        Fri,  4 Jan 2019 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546612813;
        bh=Zl3/URiqzpvTB3vS6mRLLA7ulMgDYB+jSLkrr1Xe/4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Guk+NAtQyY79sNAK4ErIZUjdtmLtDz0aTPDNVNrE8F1vTeTWykBzj+nF7ja4kzZu6
         1GnJi/3QjkqiWHkn6U0rggXvFc7foTfKZYiHiSNlsFsYYBtbkyzIb05KINLbAtNwYW
         TZ5bM5iNdINIGCqVuQyV02sX+ToMTckYD4urPPL4=
Date:   Fri, 4 Jan 2019 20:08:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: Check for driver register failure
Message-ID: <20190104143835.GE13372@vkoul-mobl.Dlink>
References: <20181228201119.11920-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228201119.11920-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-18, 14:11, Aditya Pakki wrote:
> While initializing the driver, the function platform_driver_register can
> fail and return an error. Consistent with other invocations, this patch
> returns the error upstream.

Applied, thanks

-- 
~Vinod
