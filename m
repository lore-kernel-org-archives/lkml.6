Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA7C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D952120869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBIIjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 03:39:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:51297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfBIIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 03:39:31 -0500
Received: from [192.168.178.24] ([95.116.100.134]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcvy-1h0fuU2zLe-009MV7; Sat, 09
 Feb 2019 09:39:28 +0100
To:     MRustad@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: Re: Linux 4.4.174
Openpgp: preference=signencrypt
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <24e1d121-0d48-76e8-3075-af5f80451940@gmx.de>
Date:   Sat, 9 Feb 2019 09:39:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:59eNQni2F1A/XYP+UY/ws2P1He0fyrSoMhkIMWo5dB1LxopxZ2l
 WKTNFFPk+SScDvJmUAMmlad31f4vLsjC3PTOVLLtXXADmlxQ6xhs/bLLAbfuCTOBdLALU4J
 6o+HzqT8kS9Psa2v1QwwlVKAJNmGSCwwBEcdm/6PSEwRkVINNrQDxKmueaF83AGLOqqO0pN
 5NV8TMOs1edJG9PfGIBdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uhr9AIeKCCY=:TwOuStbkrVJG3LMbrWbZzk
 4t2OzQI4vIEpG2dwj3a5Lj3I3xf+6TZ82OOyi3kmtYhvkq3sysYqD3So2RNAIj7d1NkbJTf60
 NwDdZ6jh1ie74b3D1pQjxbe9/OHO3UJCYO3PQ3BOSGRVhbQx5IXfSg7QossyLDlPcMMx0RbQ5
 BK88C5gqUfRYTd+UC27gdtCg2pIpdg3+R0A0rPKQAZiA1pO1myhwou+YuNNP55a7duEG7Jhho
 Sof2jM1a5PpGoe9u1WZUzmKr4LgQDQaJNRz9JGbRyPy4jtHoNuZS90fnW3pIFoRlkctm6Otag
 xGYRD7prcBmP5q1E8feFs/N3K9k1HghBdYHgs1ygIXiIhUrkADxHuMcZpFU58UY7B39CNae9G
 RYoFCt8UAByEgOMSul32/VmBoSoT+AOFAyozHmPAuSOakhH8x8bfjhM6+B+ohr8l2qVBwD6FD
 /WCCLJYuyqHnUUJWtGWt+I1r2VVh+MF0HyddNaXJU+feSAh7OKPZEHvZgK1pcZb/xaZEmjNRu
 mhb74GtccDUvglJD4Qb5GvSI17QPVQkhVA6CKeizirf/SH4GqKGvx43i4xT75JEU+lOBdXJpN
 Ruo3lU12GNmYoyNyFdH5LzE1z8HiNdLY2h4vPtOrWy7VniPhtBZpOXhtEK0eRALBZF1cN2F0m
 l6tF97Ei4Tlj9Q0Ef0r4ptWqKQXQk2fbKO/r/cjFqlrkEyrwKdiXV8br93OIVoqJdMJtWmFPh
 8sIITPktmp8mHTclf3XYi12kSRi1WPvJVz/ZJywxXyfj+YcrkcFbucTY1RCIqeI1b4e3hNb1j
 62cMirdZSKOOxomcDp61Ljy66Tnw+5rSsySH8ZARUxAsKDrLs86tzrD0G5nV0Tvk2oma3uDYZ
 GFik+QGa5mP95f+8nh+CkRjwtFhxM4eTQEq85yBKvjn1/pbpJp+scceXGBJz9QZO+lk7CdQQs
 FymOY8Zv6ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Feb 08, 2019 at 08:44:32PM -0800, Mark D Rustad wrote:
> On Feb 8, 2019, at 2:54 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > diff --git a/Documentation/networking/ip-sysctl.txt
> > b/Documentation/networking/ip-sysctl.txt
> > index 2ea4c45cf1c8..7c229f59016f 100644
> > --- a/Documentation/networking/ip-sysctl.txt
> > +++ b/Documentation/networking/ip-sysctl.txt
> > @@ -112,14 +112,11 @@ min_adv_mss - INTEGER
> > 
> >  IP Fragmentation:
> > 
> > -ipfrag_high_thresh - INTEGER
> > -	Maximum memory used to reassemble IP fragments. When
> > -	ipfrag_high_thresh bytes of memory is allocated for this purpose,
> > -	the fragment handler will toss packets until ipfrag_low_thresh
> > -	is reached. This also serves as a maximum limit to namespaces
> > -	different from the initial one.
> > -
> > -ipfrag_low_thresh - INTEGER
> > +ipfrag_high_thresh - LONG INTEGER
> > +	Maximum memory used to reassemble IP fragments.
> > +
> > +ipfrag_low_thresh - LONG INTEGER
> > +	(Obsolete since linux-4.17)
> 
> It seems very strange to say that it is obsolete since 4.17 in a 4.4 kernel.


4.4.174 came after 4.17, or?

-- 
Toralf
PGP C4EACDDE 0076E94E

