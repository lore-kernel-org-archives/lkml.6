Date: Wed, 21 Mar 2018 20:38:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: Vic Wei <vwei@codeaurora.org>, marcel@holtmann.org,
	linux-kernel@vger.kernel.org, majordomo@vger.kernel.org,
	stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@vger.kernel.org, kumo@qti.qualcomm.com,
	vwei@qti.qualcomm.com
Subject: Re: [PATCH 1/1] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for
 BTUSB_QCA_ROME
Message-ID: <20180321193814.GB19781@kroah.com>
References: <1521648597-2642-1-git-send-email-vwei@codeaurora.org>
 <20180321162437.GB3506@kroah.com>
 <FD229C76-5144-46E0-B7DE-47333B3B4D03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD229C76-5144-46E0-B7DE-47333B3B4D03@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 11:40:07PM +0530, Harsh Shandilya wrote:
> 
> 
> On 21 March 2018 9:54:37 PM IST, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Wed, Mar 21, 2018 at 09:09:57AM -0700, Vic Wei wrote:
> >> QCA Rome controllers can do both LE scan and BR/EDR inquiry at once.
> >> 
> >> Change-Id: I89e1412d635f4cd7b2500f7492f37430ea139f0c
> >
> >What is this line for?
> 
> That's the Change ID required by everything that goes through Gerrit. CAF (I'm assuming Vic is from CodeAurora Forums judging by the email) uses Gerrit as their review platform for the Android for MSM project.

It was a rhetorical question, I know what it is, and the fact that it
should not be in a kernel patch submission, I wanted the submitter to
learn to read their own patches _before_ they send them in.

Also, if they used checkpatch.pl, it would have told them to remove
this.

It's like saying to a kid, "what is this mess on the floor"...

greg k-h
