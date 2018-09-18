Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD88BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604BE20867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604BE20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeIRNGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727475AbeIRNGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97B283082131;
        Tue, 18 Sep 2018 07:34:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C87DD1715F;
        Tue, 18 Sep 2018 07:34:47 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:34:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180918073442.GA4805@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <3144ead9-0928-384d-0b04-fe8eb14fda52@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3144ead9-0928-384d-0b04-fe8eb14fda52@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 18 Sep 2018 07:34:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:21:25AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> Will post the next version ?

Not see Tejun's further comment yet and suppose he is fine with the
approach, so will do that soon for further review.

Thanks,
Ming
