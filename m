Date: Fri, 27 Apr 2018 17:46:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 4.4 12/50] KVM: s390: wire up bpb feature
Message-ID: <20180427154650.GA15121@kroah.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.428437126@linuxfoundation.org>
 <2764478b-8acb-653b-779f-1fb51d9a5931@de.ibm.com>
 <20180427151715.GA3876@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427151715.GA3876@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 05:17:15PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 27, 2018 at 05:10:04PM +0200, Christian Borntraeger wrote:
> > 
> > 
> > On 04/27/2018 03:58 PM, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > 
> > > 
> > > From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Ick, that is wrong right there, my scripts messed up, this should not
> have 2 author lines :(
> 
> I'll go look at all of these, odds are it made the same error
> everywhere...

Yes, I've now fixed that up in the queue.

greg k-h
