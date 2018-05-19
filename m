Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeESTyt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 15:54:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeESTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 15:54:48 -0400
Date: Sat, 19 May 2018 21:54:36 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 00/39] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1805192152420.1599@nanos.tec.linutronix.de>
References: <cover.1524649902.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette,

On Wed, 25 Apr 2018, Reinette Chatre wrote:

> This third series of Cache Pseudo-Locking enabling addresses all feedback
> received during the upstream review of RFC V2.

A very well done patch series. Was a pleasure to read. It conflicts with
Vikas series which I just applied to tip::x86/cache.

Can you please redo against that branch and address the few nitpicks I had?

Thanks,

	tglx
