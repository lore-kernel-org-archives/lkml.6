Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeELBaA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 21:30:00 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:38612 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeELB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 21:29:58 -0400
X-Google-Smtp-Source: AB8JxZodhUy+AS9wD/Zi3ldPln5warPc0NGgUK9XQbqoSYmzdfjf0Gz1gDlNryHl6166BG9loABRH8BPyPALXRa8PlM=
MIME-Version: 1.0
X-Originating-IP: [24.6.205.35]
In-Reply-To: <20180512012900.GA183767@joelaf.mtv.corp.google.com>
References: <20180512012900.GA183767@joelaf.mtv.corp.google.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 11 May 2018 18:29:57 -0700
Message-ID: <CAEXW_YSmadNG1AbdSa=ujofbZ1oQLrthWdeB+_HNMOFZQzGaxA@mail.gmail.com>
Subject: Re: [PATCH] rcu: trace: Remove Startedleaf from trace events comment
To: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 6:29 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> As part of the gp_seq clean up, the Startleaf condition doesn't occur
> anymore. Remove it from the comment in the trace event file.

Sorry, I meant here Startedleaf. Let me know if you want me to resend the patch.

thanks,

- Joel
