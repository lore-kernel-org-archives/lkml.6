Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeCZOwm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:52:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:60780 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeCZOwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:52:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="28522101"
Message-ID: <1522075953.16723.11.camel@linux.intel.com>
Subject: Re: [PATCH v3] x86: i8237: Register based on FADT legacy boot flag
From: Alan Cox <alan@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Anshuman Gupta <anshuman.gupta@intel.com>
Cc: glx@linutronix.de, x86@kernel.org, mingo@redhat.com, hpa@zytor.com,
        rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com
Date: Mon, 26 Mar 2018 15:52:33 +0100
In-Reply-To: <alpine.DEB.2.21.1803251348190.1481@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803191152450.2010@nanos.tec.linutronix.de>
         <1521714118-31282-1-git-send-email-anshuman.gupta@intel.com>
         <alpine.DEB.2.21.1803251348190.1481@nanos.tec.linutronix.de>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please explain WHY 2017 is the cut-off date. I still have no clue how
> that
> is decided aside of being a random number.

Because if it's prior to 2017 then it'll almost certainly have those
registers even if the firmware says otherwise. After that point we
think the firmware is going to give valid answers (although the 0xFF
check is actually the important one in reality).

Alan
