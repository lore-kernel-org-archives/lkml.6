Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972527AbeCSWdC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:33:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50882 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933718AbeCSPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:07 -0400
Message-Id: <20180319154124.337947038@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 19 Mar 2018 16:41:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org
Subject: [PATCH 0/2] x86: Mandate asm-goto support
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its been many _many_ years since asm-goto got introduced and recently there's
been some desire to unconditionally rely on it.

This makes the x86 build hard rely on asm-goto (effectively lifts the minimum
to GCC-4.5).
