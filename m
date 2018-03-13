Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeCMIg6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:36:58 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:44224 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeCMIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:36:56 -0400
X-Google-Smtp-Source: AG47ELubn+JTSWWeB6aZOnTk/Wx9s5C/6ow1+WFSnD3gYUT3zPKfDOJu6WmHt7ApdQNwvgxK/0tItA==
Date: Tue, 13 Mar 2018 14:06:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
Message-ID: <20180313083653.GA15832@vireshk-i7>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
 <1520924571.3766.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520924571.3766.8.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-18, 15:02, Zhang Rui wrote:
> Hi, Viresh,
> 
> I will queue it for 4.17, with just one minor fix below.
> 
> On 二, 2018-01-16 at 15:22 +0530, Viresh Kumar wrote:

> > +	cdev->stats = stats;
> > +	stats->last_time = ktime_get();
> > +	stats->max_states = states;
> > +	cdev->stats = stats;
> > +
> 
> cdev->stats is set twice here, I will remove the first one.

Thanks for catching that :)

-- 
viresh
