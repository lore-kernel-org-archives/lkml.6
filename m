Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeCUXAw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:00:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753980AbeCUXAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:00:45 -0400
Date: Wed, 21 Mar 2018 16:00:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 00/11] kexec_file: Clean up purgatory load
Message-Id: <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 12:27:40 +0100 Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:

> here is the updated patch set including Dave's comments.

There were some syntactic clashes with the "kexec_file, x86, powerpc:
refactoring for other architecutres" series.  Please check (in
linux-next) that I got it all correct and that both patch series are
functioning correctly.

I expect to send all this into Stephen for -next tomorrow.
