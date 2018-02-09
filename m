Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBIRuk convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:50:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:53697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeBIRuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:50:39 -0500
Message-ID: <1518198609.26824.43.camel@gmx.de>
Subject: Re: [RFC 2/2] Introduce sysctl(s) for the migration costs
From: Mike Galbraith <efault@gmx.de>
To: Steven Sistare <steven.sistare@oracle.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
Date: Fri, 09 Feb 2018 18:50:09 +0100
In-Reply-To: <88efe20e-75a9-6805-3ae4-dc67742f9057@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
         <1518148447.24350.34.camel@gmx.de>
         <dcc94ac7-e910-9114-2976-ac61f0ade215@oracle.com>
         <1518196102.26824.25.camel@gmx.de>
         <88efe20e-75a9-6805-3ae4-dc67742f9057@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:0nJ77jhCzr7aACMAKD7OQoVZJ1Adw6jp0KKeXtD87hpYGGr7vmb
 cb+xU/cHETvgHoJgu8wh2oyQK4NjHJaIts/I3o2PRShH1xhIn6+K5rUUtRCDr+1ctzgu7xV
 0vG2tN2IW9GW8FA4akPhIBpSVbaUyCM/Qf3J8SMQt6vVOzb0WpZrXtGAzhlfnjpjXWAROPv
 MWWBYnV0X24+S1eQnIsHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qj/NrfNYLjE=:mChXHqUlc/Gs3BcOMMcS2B
 sODaEY456+24lxF4JKJP9BcDYoHmdr0lhRt5bmjOxUSZpNV3CUacwPJq0542HyoXo1/e0+2uX
 R4yj70mOqNU7aP7FsceWnNcP8WT1CKBUv6+1KMsXvsEVVsqkhqcmf3bBfhB3S+FKlgMfkURFR
 QxEX2vBEOQwUBLHZdafsauoHHcG7a0coveNykoODrjDgfc6S+OYnHcjrF8MfPtsUfO0iUZ5zI
 SAgO/wV1/1P/1Ph2m4T5RSQnpvGA+xvObNIPwLA9Q7FvrAOAfrY0HYRMvPOEEZioKAm9cZKsf
 z6jRh9etWdtmVPZc10aLASJx0QIOYRhq4glmniahHoik9XEMpSrYse9Silc9Okv/KKBBUIB0i
 ELECsprQ89KU1+mRNyYn/g5soRi35TcfShjtVBkCmfK9AlpI0VM2LG4gJr7nprr9XZgXT9AEU
 X19fnV5B+3k6FmrI+Qfv0rBl3aKkhQOoEDpDVBC5WyKB0csddh0UE3lCa+OtzFcmW3ZzH2APR
 5uCVUat4Apw5RyVL/JcsLw8sQC1Jx1ZXtA1DHNm+R8gsUJL4NViCi4f3oadOpdd8ECe1jWjl1
 zvailDeYhD3/iYzRgQqAVcJhF0Gp8wLwiLIoy43tQD7wIFV7jLWqgJ7GdeCcyFyM4gds0M6f/
 wOwTiEo77L8aqrEKF0CLshBPXZR4xdvX91Krm2DKRdrMVH6STgKPDLl2Xom4I57ym62bRoAOR
 x0P2e+B3iKQHIs+oP5KErUjY+y/PdZoc+Krc1UxQu9YGbFIreRggBMukdltubXJLK3KQrsKXl
 /xSKhYlpNfO+kYUPvl8KoBdJ6SJQFab/n7pX3AhOEKDFiD1wYk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 12:33 -0500, Steven Sistare wrote:
> On 2/9/2018 12:08 PM, Mike Galbraith wrote:
> 
> > Shrug.  It's bogus no mater what we do.  Once Upon A Time, a cost
> > number was generated via measurement, but the end result was just as
> > bogus as a number pulled out of the ether.  How much bandwidth you have
> > when blasting data to/from wherever says nothing about misses you avoid
> > vs those you generate.
> 
> Yes, yes and yes. I cannot make the original tunable less bogus.  Using a smaller
> cost for closer caches still makes logical sense and is supported by the data.

You forgot to write "microscopic" before "data" :)  I'm mostly agnostic
about this, but don't like the yet more knobs that 99.99% won't touch.

	-Mike
