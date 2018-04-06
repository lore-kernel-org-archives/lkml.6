Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeDFTpX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:45:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDFTpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:45:22 -0400
Date: Fri, 6 Apr 2018 12:45:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tom Abraham <tabraham@suse.com>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] swap: divide-by-zero when zero length swap file on ssd
Message-Id: <20180406124521.410dbe99dcb4b5dea483f46a@linux-foundation.org>
In-Reply-To: <fdca1f72-8e51-7727-d1a0-4ccd60e80bd0@infradead.org>
References: <5AC747C1020000A7001FA82C@prv-mh.provo.novell.com>
        <fdca1f72-8e51-7727-d1a0-4ccd60e80bd0@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018 09:52:50 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> [adding linux-mm and akpm]

Thanks.

> ...

The patch is a huge mess, with leading and trailing whitespace.  I
fixed all that up, but we'd like to receive Tom's signed-off-by:, please. 
Documentation/process/submitting-patches.rst section 11 has the
details.
