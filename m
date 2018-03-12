Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCLKRd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:17:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:16613 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeCLKRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:17:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="37413677"
Message-ID: <f9098c326ab3070c3215901e3383a3a2d208b2ae.camel@linux.intel.com>
Subject: Re: Regression from efi: call get_event_log before ExitBootServices
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>, Jeremy Cline <jeremy@jcline.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: hdegoede@redhat.com, Javier Martinez Canillas <javierm@redhat.com>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Mon, 12 Mar 2018 12:17:27 +0200
In-Reply-To: <CA+zpnLdmg30Beg+uUJNgBQ5gbjXuJ0uVhyzCgf6m7xbx2yARBg@mail.gmail.com>
References: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
         <e7c2be5c-cf21-fc2d-efda-d9222d93ffad@redhat.com>
         <b32f335c-0d77-1749-f7fe-65f512280255@redhat.com>
         <ade378f6-c997-1d48-a30d-cceee6435fc8@redhat.com>
         <a3b5f822-f8f4-e2f5-46da-e23e13174f28@redhat.com>
         <cec36124-0950-6ad9-58a8-9bd69e63aa04@redhat.com>
         <0100016206a68850-bd5c96b3-f275-46ea-98b1-1317e02a5d6e-000000@email.amazonses.com>
         <29c1640a-cf19-ca19-7de9-96f202edfb5a@redhat.com>
         <CA+zpnLebtbjbA-Jg+RvMOqwDE5R--9V3hTwMk95Br4vM1LgBjQ@mail.gmail.com>
         <010001620bafa06b-41525407-603e-40a9-ba11-6033b2f5dcc7-000000@email.amazonses.com>
         <CA+zpnLdmg30Beg+uUJNgBQ5gbjXuJ0uVhyzCgf6m7xbx2yARBg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-10 at 10:45 +0000, Thiebaud Weksteen wrote:
> On Fri, Mar 9, 2018 at 5:54 PM Jeremy Cline <jeremy@jcline.org> wrote:
> > and it's hanging at "memset(log_tbl, 0, sizeof(*log_tbl) + log_size);"
> 
> Thanks. Well, it looks like the memory that is supposedly allocated is not
> usable. I'm thinking this is a firmware bug.
> Ard, would you agree on this assumption? Thoughts on how to proceed?

Check if the BIOS is up to date?

/Jarkko
