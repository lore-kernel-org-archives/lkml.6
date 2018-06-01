Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeFAJah (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:30:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeFAJ3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:29:44 -0400
Date: Fri, 1 Jun 2018 10:29:33 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com,
        joelaf@google.com, smuckle@google.com, adharmap@quicinc.com,
        skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 00/10] Energy Aware Scheduling
Message-ID: <20180601092933.GA3082@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The main new feature of this patch-set is the Energy Model framework we
discussed at OSPM. The core of it and the APIs are all implemented in
patch 03/10, so this is really where I was hoping to get some feedback.
Is the overall idea of this framework reasonable ? What do you think
about the interfaces ? Is the new config option acceptable ? And also,
is there any way I can make reviewing this patch easier ?

Thanks!
Quentin
