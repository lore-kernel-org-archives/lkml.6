Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5340FC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A51220652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A51220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030557AbeFSV4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:56:21 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:37075 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030369AbeFSV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:56:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id ACF1918224D7E;
        Tue, 19 Jun 2018 21:56:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: moon17_35752c76ca730
X-Filterd-Recvd-Size: 1864
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 21:56:07 +0000 (UTC)
Message-ID: <0dead6e0deabafe0abdd4b30f97bcdf5c12cd824.camel@perches.com>
Subject: Re: [PATCH] [Bug 16494] NFS client over TCP hangs due to packet loss
From:   Joe Perches <joe@perches.com>
To:     Andy Chittenden <andyc.bluearc@gmail.com>,
        'Trond Myklebust' <Trond.Myklebust@netapp.com>
Cc:     'Andrew Morton' <akpm@linux-foundation.org>,
        'David Miller' <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
        kaber@trash.net, eric.dumazet@gmail.com,
        William.Allen.Simpson@gmail.com, gilad@codefidence.com,
        ilpo.jarvinen@helsinki.fi, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        "'J. Bruce Fields'" <bfields@fieldses.org>,
        'Neil Brown' <neilb@suse.de>,
        'Chuck Lever' <chuck.lever@oracle.com>,
        'Benny Halevy' <bhalevy@panasas.com>,
        'Alexandros Batsakis' <batsakis@netapp.com>,
        Andy Chittenden <andyc@bluearc.com>
Date:   Tue, 19 Jun 2018 14:56:05 -0700
In-Reply-To: <4c5fc9f3.487e0e0a.2960.ffffe4ec@mx.google.com>
References: <4c57cfe8.887b0e0a.2f79.4772@mx.google.com>
         <20100803.012144.267950450.davem@davemloft.net>
         <20100803021110.f0b3877b.akpm@linux-foundation.org>
         <4C57EE9A.7040308@gmail.com>  <4c5ad0d6.42ecd80a.47d7.0dfc@mx.google.com>
         <1281037822.2948.49.camel@heimdal.trondhjem.org>
         <4c5bd64a.4a2ae30a.0283.0551@mx.google.com>
         <4c5fc9f3.487e0e0a.2960.ffffe4ec@mx.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2010-08-09 at 10:27 +0100, Andy Chittenden wrote:

You really need to check your clock.
Mail sent in the year 2010?

