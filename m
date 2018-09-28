Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039DD20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039DD20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeI1WdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:33:00 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:34582 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeI1WdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:33:00 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8SG74rM017296;
        Fri, 28 Sep 2018 17:07:04 +0100
Date:   Fri, 28 Sep 2018 17:07:04 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180928170704.7e428738@alans-desktop>
In-Reply-To: <20180927142519.GB3439@hirez.programming.kicks-ass.net>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
        <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
        <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
        <20180807183736.GR4238@tassilo.jf.intel.com>
        <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de>
        <20180807221725.GU4238@tassilo.jf.intel.com>
        <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
        <20180927142519.GB3439@hirez.programming.kicks-ass.net>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > SILVERMONT_CLIENT  	0x37	     Baytrail, Valleyview

There is no such product as Valleyview. Some things talk about
Valleyview 2 but shouldn't as that is Baytrail.

> /* "Small Core" Processors (Atom) */
> 
> #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
> #define INTEL_FAM6_ATOM_BONNELL_MID	0x26 /* Silverthorne, Lincroft */
> 
> #define INTEL_FAM6_ATOM_SALTWELL	0x36 /* Cedarview */
> #define INTEL_FAM6_ATOM_SALTWELL_MID	0x27 /* Penwell */
> #define INTEL_FAM6_ATOM_SALTWELL_TABLET	0x35 /* Cloverview */
> 
> #define INTEL_FAM6_ATOM_SILVERMONT	0x37 /* Bay Trail, Valleyview */
> #define INTEL_FAM6_ATOM_SILVERMONT_X	0x4D /* Avaton, Rangely */
> #define INTEL_FAM6_ATOM_SILVERMONT_MID	0x4A /* Merriefield */
> 
> #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
> #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
> 
> #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
> #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denvertor */
> #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */

Can you decide if you are going to consistently use the -view or the
-trail naming ? I think for our use cases you mean Pinetrail, Cedartrail,
Clovertrail, Cherrytrail as you are talking about platform (at least in
the Intel sense of the word).

Alan
