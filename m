Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946298AbeBOSkA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:40:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:35279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166726AbeBOSj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:39:58 -0500
Message-ID: <1518719968.13961.32.camel@gmx.de>
Subject: Re: [RFC 1/2] sched: reduce migration cost between faster caches
 for idle_balance
From: Mike Galbraith <efault@gmx.de>
To: Steven Sistare <steven.sistare@oracle.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
Date: Thu, 15 Feb 2018 19:39:28 +0100
In-Reply-To: <e9591680-4278-5344-6876-d16e8f9c53c4@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
         <1518147735.24350.26.camel@gmx.de>
         <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
         <1518244651.10229.66.camel@gmx.de>
         <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
         <1518718056.13961.23.camel@gmx.de>
         <e9591680-4278-5344-6876-d16e8f9c53c4@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:lyoFCwwTMKdIaA8lE2grlSB8Ldg8PnP0G4XmEE6zZkSbTgXG8XC
 loJvp9zdTQ64zTAgjxSGPXNv1MkroXvUyv5V/CCvXYnrqIKi50fyE/06wiBK3zfv8xEuIBW
 92LP575kLsvKRGLB/oI5cwVULojbpgRLDaa4LRiRIJEcWGqRpX82eT9tJMe7ffN1NJqmjip
 9yisCltKbtzl7O7FhWcfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fMybvCo3xMk=:jW8QjjR2WENBp0RH8vRo+a
 zSfNmdFM75j6al1PaGsO7O5/VyiT4wqruTbQQkV8uAuk6skg+pDtkxQUGc8yZbTZoPN0zDHmS
 JwX9gdkpKfARnLk1r/GF27I8teH1pLeDE98DXeHn3q6iQrzMfLlRVkILW2bQTvNW02dWPd0kO
 sx6wprGNcRBkAznSYGO6exWatMR/ZkSNYE0q38IgzguSe4Wlyirks4OuAlCY//O6dqdFG7kQu
 bKuXvkh0jGhu9edO8A3EYpy2O3N0mnX+h/PS5GPfgQf1FUmWwb48TDe8L4N+onDANOgw+VPWz
 sg/BmaFXjL9sHrXwUnDfARj1YuRkSVbjuVJrUsKUVNeYdyTWM9pCvhp9bDX8ASbTZ4iJL9XBa
 ZbUTxTAxoVHJfGp39hWRQpKdtVdNCrd0cj+6q6inp/MyP7Fdl7FsUaiRXJdIt5jgJMt3YTVm4
 f76JPCG6TJbW6WvCnjDTPaTcs4aiaMMxeiUNlAWaybki8foyTva+Bv3eq8CAzppJS/nn3VUVJ
 pJYarB2xTmKOr81XGRi+hcgX0xi1ZcK+w6boqpnqX4jOvj18N1/fp4JSv7qXcaX4JcS9e7rby
 KpVpPeXjtr0AckZYTQlJ4EojrcZUCIKPFJvuq1NJC+7yrkK5gv/a7cT2cjU7dsW9JvZcvWwS0
 AFcxWv906zunGhsKNkb5DWPxh1LxPF2/FXHQToCGQpBpVabjsRziacHAUQbFF67hxqd8ufyq7
 6gtzbk6PLqqDc7Knu7mJiglEPvL/Dzo/NoKYwdIfv+oCwHMxCLkrHjiPVBgQ7zglZmqdWwYQg
 BtlsAIhlRGWqT3qibi06q4E8GH5NfQ6lJWWnmSQ816SW7nyBl4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-15 at 13:21 -0500, Steven Sistare wrote:
> On 2/15/2018 1:07 PM, Mike Galbraith wrote:
> 
> >> Can you provide more details on the sysbench oltp test that motivated you
> >> to add sysctl_sched_migration_cost to idle_balance, so Rohit can re-test it?
> > 
> > The problem at that time was the cycle overhead of entering that LB
> > path at high frequency.  Dirt simple.
> 
> I get that. I meant please provide details on test parameters and config if
> you remember them.

Nope.  I doubt it would be relevant to here/now anyway.

	-Mike
