Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeFEFeT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:34:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeFEFeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:34:18 -0400
Date: Tue, 5 Jun 2018 06:34:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2 03/16] atomics/treewide: make atomic64_inc_not_zero()
 optional
Message-ID: <20180605053409.bsxh5zgsidsbqtjm@salmiak>
References: <20180529154346.3168-4-mark.rutland@arm.com>
 <mhng-bc7520a5-9be6-4f9f-b3f1-3a44d7da233e@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-bc7520a5-9be6-4f9f-b3f1-3a44d7da233e@palmer-si-x1c4>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:17:25PM -0700, Palmer Dabbelt wrote:
> On Tue, 29 May 2018 08:43:33 PDT (-0700), mark.rutland@arm.com wrote:
> > We define a trivial fallback for atomic_inc_not_zero(), but don't do
> > the same for atmic64_inc_not_zero(), leading most architectures to
> > define the same boilerplate.
> 
> atmic64

Cheers for the spot; fixed now!

Mark.
