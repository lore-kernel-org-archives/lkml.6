Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDQAnu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 20:43:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751060AbeDQAns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 20:43:48 -0400
Subject: Re: [PATCH 2/3] ACPI: SPCR: Add support for AMD CT/SZ
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel,gmane.linux.acpi.devel
References: <20180314003655.12141-1-djkurtz@chromium.org>
 <20180314003655.12141-3-djkurtz@chromium.org>
From: Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <01bc6f27-57aa-d8e9-934b-191a128543cf@jonmasters.org>
Date: Mon, 16 Apr 2018 20:43:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314003655.12141-3-djkurtz@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 08:36 PM, Daniel Kurtz wrote:
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
> earlycon setup handler to configure its input clock in order to compute
> baud rate divisor registers.
> Detect them by examining the OEMID field in the SPCR header, and pass
> then pass uart type amdcz to earlycon.

FYI I spoke with Microsoft some time ago about standardizing the ability
to convey non-standard baud rates in the SPCR. If you're interested in
driving, I can put you in touch with the right person over there.

Jon.

-- 
Computer Architect
