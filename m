Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeBSUZA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:25:00 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:60402 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932098AbeBSUY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:24:58 -0500
Date: Mon, 19 Feb 2018 20:24:40 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Benjamin Drung <benjamin.drung@profitbricks.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Read-protected UEFI variables
Message-ID: <20180219202440.2e80dfbc@alans-desktop>
In-Reply-To: <1518614486.4749.33.camel@profitbricks.com>
References: <1518612748.4749.29.camel@profitbricks.com>
        <CAKv+Gu_V7BCihPhZf=pKrkBZwFWeEoupamXvYSqdS+k93Gme=g@mail.gmail.com>
        <1518614486.4749.33.camel@profitbricks.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If the UEFI is as secure as storing an unencrypted file on a hard
> drive, I am satisfied. Or do you have a better idea where to store the
> SSH keys for a diskless system that boots via network?

Store them in the TPM ?

If you are booting over a network and not doing some kind of TPM based
trusted boot check you already lost to a network attacker 

Alan
