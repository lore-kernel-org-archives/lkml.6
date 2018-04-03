Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeDCTog (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:44:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753045AbeDCTof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:44:35 -0400
Date: Tue, 3 Apr 2018 21:44:31 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Stefan Fritsch <sf@sfritsch.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: Add emulation for movups/movupd
Message-ID: <20180403194430.GB7386@flask>
References: <20180401155444.7006-1-sf@sfritsch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180401155444.7006-1-sf@sfritsch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[The subject could mention "x86:" as well]

2018-04-01 17:54+0200, Stefan Fritsch:
> This is very similar to the aligned versions movaps/movapd.
> 
> We have seen the corresponding emulation failures with openbsd as guest
> and with Windows 10 with intel HD graphics pass through.
> 
> Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> ---

Nicely follows the implementation of aligned variants,

Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>
