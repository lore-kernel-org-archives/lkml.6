Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCTUgn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:36:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:61660 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeCTUgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:36:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,337,1517904000";
   d="scan'208";a="27415035"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "x86@kernel.org" <x86@kernel.org>
CC: "luto@kernel.org" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Topic: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Index: AQHTv61aFYaSukXqZEajMVMtZoAMNaPZTkgAgACk+4D//5LngA==
Date: Tue, 20 Mar 2018 20:36:38 +0000
Message-ID: <F3D173B5-3C01-430B-9EF0-471DDC5A4DBF@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
 <eb30911b621144fe92e77fd2d9da7efe@AcuMS.aculab.com>
 <191d8212-6740-3131-1653-d057f522843c@zytor.com>
In-Reply-To: <191d8212-6740-3131-1653-d057f522843c@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.179.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <92873EC0C656E846A8E8FB1079D23366@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KKanhA011439

> I would prefer calling it something like FIND_PERCPU_BASE or something like that.
Thanks for the suggestion.
Chang
