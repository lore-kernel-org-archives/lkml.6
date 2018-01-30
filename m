Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeA3NqH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:46:07 -0500
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:38979 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752203AbeA3NqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:46:04 -0500
X-IronPort-AV: E=Sophos;i="5.46,435,1511827200";
   d="scan'208";a="8706035"
IronPort-PHdr: =?us-ascii?q?9a23=3A2Ney8R07htiA8839smDT+DRfVm0co7zxezQtwd8Z?=
 =?us-ascii?q?sesRIv7xwZ3uMQTl6Ol3ixeRBMOHs6sC07KempujcFRI2YyGvnEGfc4EfD4+ou?=
 =?us-ascii?q?JSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgpp?=
 =?us-ascii?q?POT1HZPZg9iq2+yo9JDffxhEiCChbb9uMR67sRjfus4KjIV4N60/0AHJonxGe+?=
 =?us-ascii?q?RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L281/szrugLd?=
 =?us-ascii?q?QgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUjq+8ahkVB7oiD?=
 =?us-ascii?q?8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3RHUMhfSidNBpqw?=
 =?us-ascii?q?Y5UTA+YEO+tTsovzqEYUrRamBgeiGePhxCFGiHD00601z+MvHg7J0gE7A9IDsm?=
 =?us-ascii?q?7ZoMnvOasOU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXbJ/b8zRwlQyGQPAlFqQ?=
 =?us-ascii?q?rYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2honPnYIa0ErI9Sp+wIYrPN?=
 =?us-ascii?q?C1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtYChcCQXzpks2gTRZOadc4eS?=
 =?us-ascii?q?5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE5GripbndnIsXAAzwDT5dKdSv?=
 =?us-ascii?q?t840ehwiyD1xzT6+5YIUA0krDXK5g9zb4ripUfq0HDHi7ymEnuja+WcFsr+vSw?=
 =?us-ascii?q?5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPgQWWmiU4+W81Lnt/U3jR7VKi+U7kr?=
 =?us-ascii?q?LEv5DBPskbuq64DBNV0oYk8Rq/CSym384CkXkIK1JFZgqLj5L1NFHWPPD4EfC/?=
 =?us-ascii?q?jky3kDh13fDGMaPuD47NLnfZlLfhebZ860hGxAUvytBf4opeCqsdL/LrRk/xqN?=
 =?us-ascii?q?vYAwcjPAyw2OboEsxx2Z4AVmKRHKCZNLjfvkWM5uI0OeaAfZcVuCz6K/gn+fHh?=
 =?us-ascii?q?kWM5lUUafamz0psdcGq4Eeh+I0WFfXrshc8MEWILvgo4Q+zqj0aPUSRNaHmvX6?=
 =?us-ascii?q?Iz/C07BJi6AofEQ4CnmKaB0zujHp1KemBGDUiBEXPpd4WCRvcNZzueIsx/nTwe?=
 =?us-ascii?q?U7iuVYsh2AqwtA/11bVnNPDY+i4GupL50th6+enTmQs19TxuAMSXy3uNQH1snm?=
 =?us-ascii?q?MUWz8227hyoUh8yleFzKh5jOVUFcdN6PxVTwc6L5/cz/B6CtzrXwLBecqGSEui?=
 =?us-ascii?q?Qtq4GjwxUN0xzMEUY0pnGNWtkArD3yy0DL8RjbCLA4Y08q3E1XjrO8l902rG1L?=
 =?us-ascii?q?Umj1Q+X8RPMXOpibNx9wjUHY7Gjl6Ul7y0eqsB3C7C7nuDwXCSs0FfVQ56Sb/F?=
 =?us-ascii?q?UmwHZkvKsdT54VvPQKK0BrQhMwtO18qCKqlRZ93sk1pGQPPjN87YY2K2lGa8Hw?=
 =?us-ascii?q?qHxrSJbIDyYWUSwD3dCFQYkwAU5XuGNxIxBiK/rGLFFjBuEUjjY0br8elksnO7?=
 =?us-ascii?q?T1Q0whqNb017zbW65hoViuKGR/wP2bIEvT8rqy9oE1alw9LWF92AqhJ/c6VEe9?=
 =?us-ascii?q?w9+lZH1XnCugxlJJOgNaFihkUGcwRzpUzhywt4Bp9Hkcgwo3Mg1BByJr6A0FNd?=
 =?us-ascii?q?azOY2oj9OqXNJWnv+BCicLbW1UvD0NaS46sP7fM4q1L5vA63DEYt73Jn09xN2X?=
 =?us-ascii?q?uG+prKFBYSUY72Uksv7xh1ua3abTcn54/Oy3JsN7S7vSHY290yA+sl0BmgcsxE?=
 =?us-ascii?q?MKODEg/zE9cWCNSpKOwvyBCVaUccMfxf7ug5Oc+rbfGBwqGDJ+FmjXStimEDqL?=
 =?us-ascii?q?h0z0bE0i17UOOAi44M3vWwxgKaU3L5i1C7v4b8noUSIXk/BGu0gRDtHo9KLvl/?=
 =?us-ascii?q?ZY8RCHyGO8Stx85mg5fmVjhf7lH1Qxsk0cqkYlK3aEbn3BYYgUYepHG83y/+yj?=
 =?us-ascii?q?tuiTAyhq2F1SfKzqLpcx9RfiZnTW9jgFOkA5WugN0cRwD8YwEvlRah527/yqxf?=
 =?us-ascii?q?raJ4Py/YRkIeO2DaKHxtGo+9urSFecIHvJ8svClZV/6wSUqXRr70v10R1Ca1Wy?=
 =?us-ascii?q?NFyTQ6cSy6konolBx9zmSGJTB8q2SdMcVxwwrPocfRTuNL3yYXASx/hSTTC3Ci?=
 =?us-ascii?q?MNSzu9aZjZHOtqa5TW3lHplSdzT7iICNri224UV0DhCl2fO+gNvqFU49yyC/n/?=
 =?us-ascii?q?hsWiKAiRH4ZIDxn/C/MORoeWFyCVP84tY8EYZ7xM94jZUL0D0Wi4uY+VIOlXz6?=
 =?us-ascii?q?dM1B3qDzZ2ZLQiQEh5af2wX/10ArAzrPj6LwUnGMxIEpM8K3eGwb8iI068RbDu?=
 =?us-ascii?q?Gf67kSzgVvpV/tlh7cefhwmH8mzPIq7HMLy7UStBEF0jSWArdUG1JReyPriULb?=
 =?us-ascii?q?vJiFsKxLaTP3IvCL301kkIXkVevarw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DgAQCXc3Ba/wHyM5BbGgEBAQEBAgEBAQEIAQEBAYMVLYF?=
 =?us-ascii?q?bKINgmRFCAQEBAQEBBoE0mVyFRQKCRFgUAQEBAQEBAQECAWoogjgkAYJGAQEBA?=
 =?us-ascii?q?QIBI2YLGAICJgICVwYBEogMghwFCKVGgieEFgEBhk4BAQEHAQEBAQEjgQ+DRYI?=
 =?us-ascii?q?VgQ+FXoMvBIUGgmUFk1SQQ5VolClImFs2IoFQKwgCGAghD4JnhDwBWCM3jygBA?=
 =?us-ascii?q?QE?=
Message-ID: <1517319458.14420.1.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 0/5] selinux:Significant reduce of preempt_disable
 holds
From: Stephen Smalley <sds@tycho.nsa.gov>
To: peter.enderborg@sony.com, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, alsa-devel@alsa-project.org,
        "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 30 Jan 2018 08:37:38 -0500
In-Reply-To: <20180126143241.23108-1-peter.enderborg@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg@sony.com wrote:
> Holding the preempt_disable is very bad for low latency tasks
> as audio and therefore we need to break out the rule-set dependent
> part from this disable. By using a RCU instead of rwlock we
> have an efficient locking and less preemption interference.

NB: rcu_read_lock() may disable preemption as well if
CONFIG_PREEMPT_COUNT=y.  I assume you aren't concerned with that
configuration?

> 
> Selinux uses a lot of read_locks. This patch replaces the rwlock
> with RCY that does not hold preempt_disable.
> 
> Intel Xeon W3520 2.67 Ghz running FC27 with 4.15.0-rc9git
> (+measurement)
> I get preempt_disable in worst case for 1.2ms in
> security_compute_av().
> With the patch I get 960us as the longest security_compute_av()
> without preempt disabeld. It very much noise in the measurement
> but it is not likely a degrade.
> 
> And the preempt_disable times is also very dependent on the selinux
> rule-set.
> 
> In security_get_user_sids() we have two nested for-loops and the
> inner part calls sittab_context_to_sid() that calls
> sidtab_search_context() that has a for loop() over a while() where
> the loops is dependent on the rules.
> 
> On the test system the average lookup time is 60us and does
> not change with the RCU usage.
> 
> To use RCU the structure of policydb has to be accesses through a
> pointer.
> We need 4 patches to get there.
> 
>   [PATCH v2 1/5] selinux:Remove direct references to policydb.
>   We remove direct references and pass it through function arguments.
> 
>   [PATCH v2 2/5] selinux: Move policydb to pointer structure
>   Move the policydb to dynamic allocated structure.
> 
>   [PATCH v2 3/5] selinux: Move sidtab to pointer structure
>   Same as for policydb but for sidtab. They are closly related
>   and should be switched at the same time.
>   
>   [PATCH v2 4/5] selinux: Use pointer to switch policydb and sidtab
>   Now we can switch rules by switching pointers.
> 
>   [PATCH v2 5/5] selinux: Switch locking to RCU.
>   We are now ready to use RCU.
>   
> History: V1 rwsem
> 
