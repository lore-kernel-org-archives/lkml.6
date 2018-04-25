Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeDYUzj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:55:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52512 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeDYUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:55:36 -0400
X-Google-Smtp-Source: AIpwx49fXXv+2gCiV9pkXWt2BBI7WWaJvP7XsvqhA/ZZ6EptToaVYCpJj8FxmC0nv93CEN8Q9ZIKrA==
Date: Wed, 25 Apr 2018 23:55:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180425205531.GA9020@avx2>
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424135409.GA22709@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 06:54:09AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 24, 2018 at 12:35:34AM +0300, Alexey Dobriyan wrote:
> > Bring /proc into 21st century.
> 
> Please explain what this actually buys us except for being pointlessly
> different from the rest of the kernel?

Negative LOC diff, less junk in preprocessor hashtables.
