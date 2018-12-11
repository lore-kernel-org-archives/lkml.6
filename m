Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16117C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB60A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB60A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeLKKsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:48:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37854 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:48:32 -0500
Received: from [88.128.81.80] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWfaL-00019d-21; Tue, 11 Dec 2018 11:48:18 +0100
Date:   Tue, 11 Dec 2018 11:47:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     linux-mm@kvack.org, mhocko@suse.com, bp@suse.de,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, torvalds@linux-foundation.org,
        hpa@zytor.com, jkosina@suse.cz, ak@linux.intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/speculation/l1tf: Drop the swap storage limit
 restriction when l1tf=off
In-Reply-To: <20181211090056.GA30493@gmail.com>
Message-ID: <alpine.DEB.2.21.1812111147300.8611@nanos.tec.linutronix.de>
References: <20181113184910.26697-1-mhocko@kernel.org> <tip-f4abaa98c4575cc06ea5e1a593e3bc2c8de8ef48@git.kernel.org> <20181211090056.GA30493@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Ingo Molnar wrote:
> >    off		Disables hypervisor mitigations and doesn't emit any
> >  		warnings.
> > +		It also drops the swap size and available RAM limit restrictions
> > +                on both hypervisor and bare metal.
> > +
> 
> Note tha there's also some whitespace damage here: all other similar 
> lines in this RST file start with two tabs, this one starts with 8 
> spaces.

Fixed...
