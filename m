Date: Mon, 23 Apr 2018 12:26:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 11/22] driver core: add per device iommu param
Message-ID: <20180423102606.GA29194@kroah.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-12-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523915351-54415-12-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 02:49:00PM -0700, Jacob Pan wrote:
> DMA faults can be detected by IOMMU at device level. Adding a pointer
> to struct device allows IOMMU subsystem to report relevant faults
> back to the device driver for further handling.
> For direct assigned device (or user space drivers), guest OS holds
> responsibility to handle and respond per device IOMMU fault.
> Therefore we need fault reporting mechanism to propagate faults beyond
> IOMMU subsystem.
> 
> There are two other IOMMU data pointers under struct device today, here
> we introduce iommu_param as a parent pointer such that all device IOMMU
> data can be consolidated here. The idea was suggested here by Greg KH
> and Joerg. The name iommu_param is chosen here since iommu_data has been used.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Link: https://lkml.org/lkml/2017/10/6/81

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
