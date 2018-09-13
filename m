Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD64FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD1C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD1C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeINB5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:57:02 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:33540 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbeINB5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:57:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 81470100E86C1;
        Thu, 13 Sep 2018 20:45:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trail03_503d12a6fb148
X-Filterd-Recvd-Size: 1507
Received: from XPS-9350 (unknown [172.56.12.197])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Sep 2018 20:45:51 +0000 (UTC)
Message-ID: <c7a3263ac94a6c31bd58c06683d55015be2e8be4.camel@perches.com>
Subject: Re: [PATCH v2] staging: Convert to using %pOFn instead of
 device_node.name
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Arkver <ian.arkver.dev@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org
In-Reply-To: <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
References: <20180828154433.5693-1-robh@kernel.org>
         <20180828154433.5693-7-robh@kernel.org> <20180912121705.010a999d@coco.lan>
         <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date:   Thu, 13 Sep 2018 04:50:23 -0700
Mime-Version: 1.0
X-Mailer: Evolution 3.28.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-12 at 15:26 -0500, Rob Herring wrote:
> A problem with MAINTAINERS is there is no way to tell who applies
> patches for a given path vs. anyone else listed.

try the --scm option

