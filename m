Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCWSmq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:42:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:42400 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbeCWSmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:42:44 -0400
Date: Fri, 23 Mar 2018 12:42:43 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Joel Stanley <joel@jms.id.au>
Cc: "Tobin C . Harding" <me@tobin.cc>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Mention why %p prints ptrval
Message-ID: <20180323124243.64fdc17b@lwn.net>
In-Reply-To: <20180322052336.1001-1-joel@jms.id.au>
References: <20180322052336.1001-1-joel@jms.id.au>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018 15:53:36 +1030
Joel Stanley <joel@jms.id.au> wrote:

> When debugging recent kernels, people will see '(ptrval)' but there
> isn't much information as to what that means. Briefly describe why it's
> there.

Applied, thanks.

jon
