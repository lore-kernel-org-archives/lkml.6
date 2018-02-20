Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeBTLJR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:09:17 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:51831 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeBTLJP (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Tue, 20 Feb 2018 06:09:15 -0500
Message-Id: <5A8C0FE702000078001A9878@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Tue, 20 Feb 2018 04:09:11 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Ingo Molnar" <mingo@kernel.org>
Cc: <mingo@elte.hu>, <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH RESEND] x86: consider effective protection
 attributes in W+X check
References: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
 <20180220081042.wgriecqneizg3df7@gmail.com>
 <5A8BE8C602000078001A9729@prv-mh.provo.novell.com>
 <20180220083731.kzkctvwvtc4qhrdi@gmail.com>
 <5A8BEDBE02000078001A9763@prv-mh.provo.novell.com>
 <20180220101727.c4akak6cgoqbgn2y@gmail.com>
In-Reply-To: <20180220101727.c4akak6cgoqbgn2y@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 20.02.18 at 11:17, <mingo@kernel.org> wrote:
> I assume the Xen fix got merged meanwhile?

Yes (that's the commit I've referred to in an earlier reply).

Jan
