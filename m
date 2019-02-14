Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C621928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436725AbfBNR2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:28:50 -0500
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:43216 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730560AbfBNR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:28:50 -0500
X-Greylist: delayed 1090 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2019 12:28:50 EST
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92-RC5)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1guKWx-0005yB-V1; Thu, 14 Feb 2019 12:10:37 -0500
Date:   Thu, 14 Feb 2019 12:10:34 -0500
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2] coda: get rid of CODA_FREE()
Message-ID: <20190214171019.fhvwee2ngiqqb3pi@cs.cmu.edu>
Mail-Followup-To: Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1902140804170.2466@hadrien>
 <20190214083822.GA28623@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214083822.GA28623@kadam>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:38:22AM +0300, Dan Carpenter wrote:
> The CODA_FREE() macro just calls kvfree().  We can call that directly
> instead.

Added these to my (getting long) list of things that I really should get
upstreamed sometime soon now.

Jan
