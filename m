Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDCRGf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeDCRGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:06:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED30D2178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
X-Google-Smtp-Source: AIpwx49c/K/JGwPB08qYv0qIOROP7ouhSLADlpqfVQ8o5RGxUrtZBR7f7/nLNKm5uZLy7Ra1wnpfH3oHjVm6dfRx3z4=
MIME-Version: 1.0
In-Reply-To: <20180403165627.GW30543@wotan.suse.de>
References: <1510347775.3549.2.camel@linux.vnet.ibm.com> <21dd4b88-f6e7-f6bb-e34d-ba8ef3755622@kernel.org>
 <20180403165627.GW30543@wotan.suse.de>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Tue, 3 Apr 2018 10:06:10 -0700
X-Gmail-Original-Message-ID: <CAB=NE6UZbBWn1WCfM5in1w32ZXNaV25_uz+=TVyu4Y-35Rv72A@mail.gmail.com>
Message-ID: <CAB=NE6UZbBWn1WCfM5in1w32ZXNaV25_uz+=TVyu4Y-35Rv72A@mail.gmail.com>
Subject: Re: [RFC PATCH v1] fw_lockdown: new micro LSM module to prevent
 loading unsigned firmware
To: Andy Lutomirski <luto@kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>, Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Gary Lin <GLin@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 9:56 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> The biggest thing which has changed since then is that we decided to *not*
> support or streamline generic firmware signing (non-IMA) for now for a few
> reasons [0] [1] which are important to re-iterate as these are easy to forget,
> and AFAICT not documented anywhere.

And the URLs...

[0] https://lkml.kernel.org/r/20171204195155.GU729@wotan.suse.de
[1] https://lkml.kernel.org/r/20171207153209.5da771a9@alans-desktop

  Luis
