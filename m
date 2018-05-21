Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeEUOKM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:10:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:21105 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbeEUOKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:10:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="57097456"
Date: Mon, 21 May 2018 07:10:09 -0700
From: Andi Kleen <ak@linux.intel.com>
To: whiteheadm@acm.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86: Fix AMD K6 indirect call check v2
Message-ID: <20180521141009.GG4486@tassilo.jf.intel.com>
References: <CAP8WD_apEh=a8m2zJtUwcFpMRYh3ffjTbT5983413hrfE0w05w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_apEh=a8m2zJtUwcFpMRYh3ffjTbT5983413hrfE0w05w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 07:13:37AM -0400, tedheadster wrote:
> Andi,
>   I have a K6 regression testing system. I think my K6 is a revision
> C, but I probably can get an earlier cpu (with the bug) to test on.
> 
> Do you have any specific tests you would want me to do on the affected cpu?

You answered to an ancient email? Can barely remember what it was about.
But I think if it still boots it's likely fine.

-Andi
