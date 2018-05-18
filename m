Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeERRGH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:06:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:06:06 -0400
Date: Fri, 18 May 2018 10:06:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Simon Que <sque@chromium.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should new code have forward declarations of static functions or
 not?
Message-ID: <20180518170605.GA22641@infradead.org>
References: <CANV8Hs3Rc1q_Qcp05jGfuVwqTFg0c9UhNebk24UYGkkGiHpPRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANV8Hs3Rc1q_Qcp05jGfuVwqTFg0c9UhNebk24UYGkkGiHpPRA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:44:31PM -0400, Simon Que wrote:
> Is it preferred to have forward declarations of static funcs, or to omit
> them altogether?

There are cases where you need them.  But in general if you do not
absolutely need them try to avoid them.
