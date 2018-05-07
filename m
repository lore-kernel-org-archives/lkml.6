Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeEGKrM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:47:12 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:40397 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeEGKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:47:10 -0400
X-Google-Smtp-Source: AB8JxZpZMu5IHfJ27fk0TJIT4EzgGsU5UjG2baGitGu0T6MSlEqVL5mFB7DLKHObpbB7RO6kf0WQ4Q==
Date: Mon, 7 May 2018 13:47:11 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Larry Woodman <lwoodman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Introduce 'no5vl kernel parameter
Message-ID: <20180507104711.fjs6264dmdifd6qs@kshutemo-mobl1>
References: <20180502161027.36395-1-kirill.shutemov@linux.intel.com>
 <20180506173315.GA14673@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506173315.GA14673@xo-6d-61-c0.localdomain>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 07:33:52PM +0200, Pavel Machek wrote:
> On Wed 2018-05-02 19:10:27, Kirill A. Shutemov wrote:
> > The kernel parameter allows to force kernel to use 4-level paging even
> > if hardware and kernel support 5-level paging.
> > 
> > The option may be useful to workaround regressions related to 5-level
> > paging.
> 
> There's typo in subject.

Fixed in v2.

-- 
 Kirill A. Shutemov
