Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDYHCE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:02:04 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37976 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeDYHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:01:59 -0400
X-Google-Smtp-Source: AIpwx4/WjCWTs0mh2IsZ1L91gWWWmZ/nPNIjzLanuoxy0Re3hHl5UtyTOzQ3vOWE3REIp5vO0S6xIw==
Date: Wed, 25 Apr 2018 00:01:56 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH] x86/vector: Remove the macro VECTOR_OFFSET_START
In-Reply-To: <20180425020553.17210-1-douly.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1804250001230.51102@chino.kir.corp.google.com>
References: <20180425020553.17210-1-douly.fnst@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Dou Liyang wrote:

> Now, Linux uses matrix allocator for vector assignment, the original
> assignment code which used VECTOR_OFFSET_START has been removed.
> 
> So remove the stale macro as well
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

This was removed in 4.15 by commit 69cde0004a4b ("x86/vector: Use matrix 
allocator for vector assignment").

Acked-by: David Rientjes <rientjes@google.com>
