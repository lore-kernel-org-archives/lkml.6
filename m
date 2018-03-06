Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbeCFOF4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:05:56 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37066 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbeCFOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:05:54 -0500
X-Google-Smtp-Source: AG47ELsA2+POC50h1dk6qSzOCQ8JXtQ16UhknbFB26i+1Ai6TQJMPvjZoxlADmVc3FPZKRH/GoJ++A==
Subject: Re: [PATCH 0/9] KEYS: Blacklisting & UEFI database load
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc: matthew.garrett@nebula.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <147931984418.16460.6639993676886095760.stgit@warthog.procyon.org.uk>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <6eabbb43-295e-9ba0-c0d9-120f48aa0e1d@suse.cz>
Date: Tue, 6 Mar 2018 15:05:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <147931984418.16460.6639993676886095760.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2016, 07:10 PM, David Howells wrote:
> Here are two sets of patches.  Firstly, the first three patches provide a
> blacklist, making the following changes:
...
> Secondly, the remaining patches allow the UEFI database to be used to load
> the system keyrings:
...
> Dave Howells (2):
>       efi: Add EFI signature data types
>       efi: Add an EFI signature blob parser
> 
> David Howells (5):
>       KEYS: Add a system blacklist keyring
>       X.509: Allow X.509 certs to be blacklisted
>       PKCS#7: Handle blacklisted certificates
>       KEYS: Allow unrestricted boot-time addition of keys to secondary keyring
>       efi: Add SHIM and image security database GUID definitions
> 
> Josh Boyer (2):
>       MODSIGN: Import certificates from UEFI Secure Boot
>       MODSIGN: Allow the "db" UEFI variable to be suppressed

Hi,

what's the status of this please? Distributors (I checked SUSE, RedHat
and Ubuntu) have to carry these patches and every of them have to
forward-port the patches to new kernels. So are you going to resend the
PR to have this merged?

thanks,
-- 
js
suse labs
