Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872240-1523534500-2-6640262677016657685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523534499; b=HUZM9CiWKoR22B61byYEbMHJT7zeIJRzuIOOQoMgJCPyep8v3n
    wGh7WY+waUlyW09d61JP+w6X202JQApMa90BhK09wgBygilR0uqenAkMur0LDSfg
    t2haP0rffFW+OkwZ1ZFgJJwUYPoNM+raxZ2EVD1v6m/e4JHrJuNH2YXROMhY/ql1
    IjQfcvXTQzUiPVqmC7tnks+qAP0eMnVRY1XYw6NTkYl7t41nlMVaiDQJAzg5iWs2
    IPe5xWZ5ASPl2/KjCEih6jhBwmdEIE0177dd2tfsd6jA9AMixVWylrukISf8wsmY
    +IDufO++RCkQof4ZRR12+nlW3Kj5pWWt5Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523534499; bh=IgepB/TlkYt3nhuDFSQY4bnijV86sE
    zDch/6yF/8cTE=; b=GEbD8O7wI6QgWgi6PzJw8rEjl0DgcIRq+ziJs+10WP6Qt6
    NVQfca9T7FWItyHQze1zWOvGCaQ7BbTwPMSTk5w7oQmgsjzZVnlfsmIcSLQ2gqLa
    CqitxFJqVAy18M3JcF9/OAUSS2ySGcMpdOVj2ancYyuoTJj1h6iifbKZbNAWtHx1
    6pB8Pog3h5AnA1caFPBrgTOcWx0TGW1Mt7+npstYXnwBIiSvKCbP6P6OTlRAUjd0
    QSg5lz8tAvM/hGL5yoyUiuNrFNCi1wrCyQEDJXRzPRLlOAAmEVGMbKItnF15WHpk
    fM6tGQJh7BKxT3ewV+AgUU2ZxMznpuCaxap+Ukqw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOaO26rbjqoO87rbFNqyRU1OJYhdNcdIRQ2LAJO0SkrglqAWVnUpWYpYDaw1Cg7VPOANEFzMz8yz4ye9kz+J1vJ7ys7nicyX6RXmzOEk3rtJ4Uoft4x9
    RRrdQuIoo7KlJxJrDELSstCOPgwodRhGYxaTJfw4MA7hi615NycucafB+eWfziqM3K9jLMXIWmgvz5vLjFmE76ltgItO81ojrIzKkmFGakfWQ3qNF1jBLj42
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=57SyGIRnAAAA:8 a=V-8kuOT52EEqO0DzEwcA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeDLMBh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 08:01:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:50520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeDLMBg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Apr 2018 08:01:36 -0400
Date: Thu, 12 Apr 2018 14:01:33 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Joonsoo Kim <js1304@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: don't reserve ZONE_HIGHMEM for
 ZONE_MOVABLE request
Message-ID: <20180412120133.GD23400@dhcp22.suse.cz>
References: <1504672525-17915-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20170914132452.d5klyizce72rhjaa@dhcp22.suse.cz>
 <CAAmzW4NGv7RyCYyokPoj4aR3ySKub4jaBZ3k=pt_YReFbByvsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmzW4NGv7RyCYyokPoj4aR3ySKub4jaBZ3k=pt_YReFbByvsw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 04-04-18 09:24:06, Joonsoo Kim wrote:
> 2017-09-14 22:24 GMT+09:00 Michal Hocko <mhocko@kernel.org>:
> > [Sorry for a later reply]
> >
> > On Wed 06-09-17 13:35:25, Joonsoo Kim wrote:
> >> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >>
> >> Freepage on ZONE_HIGHMEM doesn't work for kernel memory so it's not that
> >> important to reserve.
> >
> > I am still not convinced this is a good idea. I do agree that reserving
> > memory in both HIGHMEM and MOVABLE is just wasting memory but removing
> > the reserve from the highmem as well will result that an oom victim will
> > allocate from lower zones and that might have unexpected side effects.
> 
> Looks like you are confused.
> 
> This patch only affects the situation that ZONE_HIGHMEM and ZONE_MOVABLE is
> used at the same time. In that case, before this patch, ZONE_HIGHMEM has
> reserve for GFP_HIGHMEM | GFP_MOVABLE request, but, with this patch,  no reserve
> in ZONE_HIGHMEM for GFP_HIGHMEM | GFP_MOVABLE request. This perfectly
> matchs with your hope. :)

I have forgot all the details but my vague recollection is that the
concern was that GFP_HIGHUSER_MOVABLE etc. wouldn't keep any reserve in
the highmem zone and so emergency allocations - e.g. those during OOM
will have to fallback to kernel zones and might lead to hard to predict
results. Am I still confused and this will not happen after the patch?
-- 
Michal Hocko
SUSE Labs
