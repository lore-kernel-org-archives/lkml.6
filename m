Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbeBSXh6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:37:58 -0500
Received: from edison.jonmasters.org ([173.255.233.168]:59916 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeBSXh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:37:57 -0500
To: David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Cc: Ingo Molnar <mingo@kernel.org>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
 <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
 <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
 <1518509708.12890.33.camel@infradead.org>
 <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
 <1518517262.12890.43.camel@infradead.org>
 <1518518198.12890.48.camel@infradead.org>
 <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com>
 <1518775136.7876.13.camel@infradead.org>
 <75287047-77a0-e0ff-c2e8-61c81641251e@redhat.com>
 <1518776517.7876.21.camel@infradead.org>
 <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com>
 <1518783021.7876.34.camel@infradead.org>
From: Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation Of Broken Dreams
Message-ID: <4882860e-23c5-75b3-ac02-c700f615156e@jonmasters.org>
Date: Mon, 19 Feb 2018 18:37:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518783021.7876.34.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 82.111.139.164
X-SA-Exim-Mail-From: jcm@jonmasters.org
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2018 07:10 AM, David Woodhouse wrote:
> On Fri, 2018-02-16 at 12:04 +0100, Paolo Bonzini wrote:
>> On 16/02/2018 11:21, David Woodhouse wrote:

>>> Even if the guest doesn't have/support IBRS_ALL, and is frobbing the
>>> (now emulated) MSR on every kernel entry/exit, that's *still* going to
>>> be a metric shitload faster than what it *thought* it was doing.

Is there any indication/log to the admin that VM doesn't know about
IBRS_ALL and is constantly uselessly writing to an emulated MSR?

While it's probably true that the overhead in time is similar to (or
better than) an actual IBRS MSR write, if the admin/user knows the VM
needs updating, then there's a fighting chance that they might do so.

Jon.
