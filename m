Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeDDRfy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:35:54 -0400
Received: from manul.sfritsch.de ([138.201.64.112]:35376 "EHLO
        manul.sfritsch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDDRfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:35:53 -0400
From: Stefan Fritsch <sf@sfritsch.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: Add emulation for movups/movupd
Date: Wed, 04 Apr 2018 19:35:40 +0200
Message-ID: <1883982.uaQK4EgVKX@k>
In-Reply-To: <288c32e4-a1ec-7b43-0d6a-6a7c0e1a04b2@redhat.com>
References: <20180401155444.7006-1-sf@sfritsch.de> <20180404171040.GW5438@char.us.oracle.com> <288c32e4-a1ec-7b43-0d6a-6a7c0e1a04b2@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 4 April 2018 19:24:20 CEST Paolo Bonzini wrote:
> On 04/04/2018 19:10, Konrad Rzeszutek Wilk wrote:
> > Should there be a corresponding test-case?
> 
> Good point!  Stefan, could you write one?

Is there infrastructure for such tests? If yes, can you give me a pointer to 
it?

Cheers,
Stefan
