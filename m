Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE3DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A0206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfBVWt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:49:56 -0500
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:48202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbfBVWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:49:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2C039181D3403;
        Fri, 22 Feb 2019 22:49:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: yard23_73894d74bfc5e
X-Filterd-Recvd-Size: 1512
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Feb 2019 22:49:53 +0000 (UTC)
Message-ID: <f07d06d04b5a7ac7f1b35cd1217f0840009302a4.camel@perches.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Ampere email address
From:   Joe Perches <joe@perches.com>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Open Source Submission <patches@amperecomputing.com>
Date:   Fri, 22 Feb 2019 14:49:52 -0800
In-Reply-To: <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
References: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com>
         <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-22 at 22:43 +0000, Khuong Dinh wrote:
>    Do you have any feedback for this?

It's trivial, though it might be nice to describe
in the commit message why specific maintainers are
being changed from one person to another.

If you are not going to send a pull request for it,
send it to 'Andrew Morton <akpm@linux-foundation.org>'
if no one else picks it up.


