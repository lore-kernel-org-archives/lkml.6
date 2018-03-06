Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeCFOUT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:20:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:50506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeCFOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:20:17 -0500
Date: Tue, 6 Mar 2018 15:20:15 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] HID: hid-ntrig: use true and false for boolean values
In-Reply-To: <20180306000624.GA2680@embeddedgus>
Message-ID: <nycvar.YFH.7.76.1803061519430.15778@cbobk.fhfr.pm>
References: <20180306000624.GA2680@embeddedgus>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2018, Gustavo A. R. Silva wrote:

> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I've commited this (and the hid-multitouch variant of it as well) to 
for-4.17/upstream.

-- 
Jiri Kosina
SUSE Labs
