Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeEUU6B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:58:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:62742 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbeEUU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:57:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="51037062"
Date: Mon, 21 May 2018 13:57:52 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180521205751.GA19282@agluck-desk>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
 <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
 <20180520204032.GA19845@pd.tnic>
 <CAG=yYw=bdgsTSW80R1Wt9uUTtXeMwX5macbjrPBNzVLihk-Ufw@mail.gmail.com>
 <20180521165803.GA15717@agluck-desk>
 <CAG=yYw=OQ7zpyK-5iqg7uQvcykTvuhQfX=RFg3GpQGvCRowd=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYw=OQ7zpyK-5iqg7uQvcykTvuhQfX=RFg3GpQGvCRowd=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess I didn't explain that very clearly.  I need all the lines
in betweeen.

How about this:

$ sudo dmesg -r | grep -C 30 Bank

-Tony
