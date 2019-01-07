Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3A2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfAGWoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:44:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGWoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:44:13 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F5485A8;
        Mon,  7 Jan 2019 22:44:12 +0000 (UTC)
Date:   Mon, 7 Jan 2019 14:44:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     rppt@linux.ibm.com, Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, riel@redhat.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: Create the new vm_fault_t type
Message-Id: <20190107144411.b3e2313649f106de0776432e@linux-foundation.org>
In-Reply-To: <CAFqt6zYY=xfqvVxRi1spbMNzvoM_CYNxbm6d7_79a5bBHxUzuA@mail.gmail.com>
References: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
        <20181115014737.GA2353@rapoport-lnx>
        <CAFqt6zbOgSm9omt+6iV0GJtZdZ_qyTr9Jte9ZGYRQ1M4CdB-mA@mail.gmail.com>
        <CAFqt6zZ67tFA8FjFZ4xM+YUAez9EdPHinx0ky0X5sQHyZ9nkLg@mail.gmail.com>
        <CAFqt6zYY=xfqvVxRi1spbMNzvoM_CYNxbm6d7_79a5bBHxUzuA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 11:47:12 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> > Do I need to make any further improvement for this patch ?
> 
> If no further comment, can we get this patch in queue for 5.0-rcX ?

I stopped paying attention a while ago, sorry.

Please resend everything which you believe is ready to go.
